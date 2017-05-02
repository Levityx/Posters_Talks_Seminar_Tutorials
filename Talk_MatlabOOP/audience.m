classdef audience < handle 
    
    properties 
        % For some properties, the data type and/or dimension is resctricted:
        % propName@className     dimensionType   = initialValue
        % compulsory[@optional]   [optional]     [  optional  ]
        time                    = datestr( now )
        nbPeople@double scalar  = 0
        isnice@logical          = true
        venue@char              
        nbPplKnowObjects        = 0
        nbPplKnowStructures     = 0
        nbPplKnowInheritance    = 0
        nbPplUsedOOP            = 0
        nbPplWrittenClasses     = 0
    end
    
    methods 
        function obj = audience( varargin )
            % Constructor
            switch length(varargin)
                % Other way to give default value
                case 0, obj.venue = 'The wall, at home'; 
                case 1, obj.venue = varargin{1};
                otherwise, error(['Audience''s constructor accepts only '...
                    'a single string as input.']);
            end
        end
        
        function setNbPeople( obj, value )
            % Only defined to demonstrate usage in an arrayfun
            obj.nbPeople = value;
        end
        
        function set.time(~,~)
            % If we try to set time, do something unexpected.
            disp('You didn''t see that coming, did you?');
        end
        
        function obj = plus( obj1, obj2 )
            % Overloading function 'plus' to create an arithmetic with our
            % classes.
            obj = audience;
            obj.nbPeople = obj1.nbPeople + obj2.nbPeople;
            obj.isnice = obj1.isnice && obj2.isnice;
            obj.venue = [obj1.venue '_' obj2.venue];
            obj.nbPplKnowObjects = obj1.nbPplKnowObjects + obj2.nbPplKnowObjects;
            obj.nbPplKnowStructures = obj1.nbPplKnowStructures + obj2.nbPplKnowStructures;
            obj.nbPplKnowInheritance = obj1.nbPplKnowInheritance + obj2.nbPplKnowInheritance;
            obj.nbPplUsedOOP = obj1.nbPplUsedOOP + obj2.nbPplUsedOOP;
            obj.nbPplWrittenClasses = obj1.nbPplWrittenClasses + obj2.nbPplWrittenClasses;
        end
        
    end
end
