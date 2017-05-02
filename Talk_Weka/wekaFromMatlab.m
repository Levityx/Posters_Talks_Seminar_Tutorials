% Weka tutorial: Interfacing Matlab with Weka.
% Alban@ihr.mrc.ac.uk
%
% This script loads an arff file into Matlab, applies a filter on it,
% runs a classification and display some results.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2016, Alban Levy
% 
% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the "Software"), to 
% deal in the Software without restriction, including without limitation the 
% rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
% sell copies of the Software, and to permit persons to whom the Software is 
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL  
% THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER  
% DEALINGS IN THE SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Inspired by classifyWekaData (to be released).
% Uses Matt Dunham's work to
%   load weka's arff files (not necessary to download it)
%   http://www.mathworks.com/matlabcentral/fileexchange/21204-matlab-weka-interface
%
% Tested using:
%   MATLAB Version: 8.5.0.197613 (R2015a)
%   Operating System: Mac OS X  Version: 10.10.1 Build: 14B25 
%   Java Version: Java 1.7.0_60-b19 with Oracle Corporation Java HotSpot(TM)
%       64-Bit Server VM mixed mode



%%% Give paths to %%%
% - weka.jar:
myPath.wekaJar  = fullfile('/Applications','weka-3-6-11-oracle-jvm.app','Contents','Java','weka.jar');
% - folder containing the ARFF files we'll use:
myPath.wekaData = fullfile('/Users/pmaal/weka_data/'); 
% - matlab2weka folder (contains Matt's scripts, including loadARFF.m):
myPath.M2W      = fullfile('/Users/pmaal/Documents/MATLAB','ML_Classification','matlab2weka'); 


%%% Choices %%%
% Classifier, filter and dataset we want.
% Classifier with options (default option, actually no need to specify)
WPackage = 'trees';
WClass   = 'J48';
WOption  = '-C 0.25 -M 2'; 
% Filter with option (default is '-R first-last')
WFilter_name = 'NumericToNominal';
WFilter_val  = '-R first'; 
% Dataset
WArff    = fullfile(myPath.wekaData, 'iris.arff');


%%% NOTE on javapaths %%%
% javapaths can be added dynamically (javaaddpath) 
% or statically (edit classpath.txt).
%
% First, let's check we haven't added the javapath yet, so we get an error
import('weka.core.Instances');
% If I had already, let's use javarmpath(myPath.wekaJar) to remove it!
% Remarks: 
%   import('weka.core.Instances.*');
% and 
%   import 'weka.core.Instances';
% are both accepted, but beware: the first one will not trigger an error. 
%
% Let's add it dynamically 
javaaddpath(myPath.wekaJar); 
% If you installed 3rd party packages, you'll need to javaaddpath them as well


% Import a few packages
import('weka.core.Instances');
import('weka.classifiers.Classifier');
import('java.lang.StringBuffer');
import('weka.classifiers.evaluation.output.prediction.*');
import('weka.classifiers.Evaluation');
import('java.util.Random');


% Import classifier
WClassifier = sprintf('weka.classifiers.%s.%s', WPackage, WClass);
import( WClassifier  );


%%% Define java string objects %%%
% after importing the right packages 
cloutput = PlainText();
cloutputbuf = java.lang.StringBuffer();
cloutput.setBuffer(cloutputbuf);


%%%% Create classifier object %%%%
cls = javaObject( WClassifier );
% Remark this is a java object of class weka.classifiers.trees.J48
% Hence it has some methods 
methods(cls);
% but the help won't work
help cls;
% Hopefully, you have access to the information elsewhere, either in the
% source code, or through some specific methods
disp(cls.globalInfo);
weka.classifiers.(WPackage).(WClass).main('-h')
% The 'set' and 'get' methods are stereotypical. For example, to set options:
cls.setOptions(  weka.core.Utils.splitOptions( WOption )  );
% and check them
cls.getOptions


%%% Load ARFF data %%
% into Matlab, using code written by Matt Dunham "wekaData = loadARFF(WArff);"
addpath(myPath.M2W);
import weka.core.converters.ArffLoader;
import java.io.File;    
loader = ArffLoader();
loader.setFile(File(WArff));
wekaData = loader.getDataSet();
wekaData.setClassIndex(wekaData.numAttributes - 1);
% which builds an object of class weka.core.Instances. Let's check it out
disp(wekaData.methods);
disp(wekaData.classIndex); % What is this value?
disp(wekaData.classAttribute); % to check, and we can use .setClassIndex(?) to change it


%%% Prepare filter %%%
import(['weka.filters.unsupervised.attribute.' WFilter_name]);
WFilter = weka.filters.unsupervised.attribute.(WFilter_name)();
disp(WFilter.getOptions); 
WFilter.setOptions(weka.core.Utils.splitOptions(WFilter_val) );
WFilter.setInputFormat(wekaData);
% Apply filter: look at what happens to wekaData at the same time
wekaData = WFilter.useFilter(wekaData, WFilter);


%%% Evaluation %%%
% using stratified 10-fold Cross-Validation
cls.buildClassifier( wekaData ); % Build model using the whole dataset
eval = Evaluation( wekaData );
folds = 10;
eval.crossValidateModel(cls, wekaData , folds, Random(1),cloutput);


%%% Display %%%
disp(eval.toSummaryString(java.lang.String(['====== ',WClassifier,' ======']), true));
disp(eval.toSummaryString); % same, without the nice '===...==='
% Note that, for examplle, 
disp(class(eval.toSummaryString));
% eval.toSummaryString          is a Java string, but
disp(class(char(eval.toSummaryString)));
% char(eval.toSummaryString)    makes it a Matlab string.
% For fun, try 
eval.toSummaryString(0) 
eval.toSummaryString(1)
% to realise that 0 or 1 are inputs to the method 'toSummaryString', not
% elements of a Java string.


%%% MEMORY LEAKS %%%
% Matlab is known to have memory leaks, and it is quite hard to make sure
% that objects get properly removed from memory.
% 
% Let's try 
javarmpath(fullfile('/Applications','weka-3-6-11-oracle-jvm.app','Contents','Java','weka.jar'));
% So we need to clean things manually
clear cloutput cloutputbuf cls eval wekaData WFilter;
% but don't trust necessarily Matlab on these things.


%%%%% FAQ
%%% Is it possible to get some 'help' on java objects?
% Only of you where to find it. Ex:
weka.classifiers.(WPackage).(WClass).main('-h')

%%% Why do some methods on cls trigger errors but are visible? 
% I don't know. Maybe they are 'abstract' methods, not implemented for this
% specific subclass of weka.classifiers...


