classdef myClassSyntax < superClass1 & superClass2
    properties ( Attribute1 = value1, Attribute2 = value2 )
    end
    
    methods ( Attribute1 = value1, Attribute2 = value2 )
        function obj = myClassSyntax( arg1,arg2, arg3 ) 
             % Constructor method
             % The constructor can take any number of arguments specifying 
             % initial values for the properties for instance, and must return 
             % one argument, the constructed object. 
        end
        
        function out = funcName( obj, arg1 ) 
            % A method called funcName
        end
    end
    
    events (Attribute1 = value1, Attribute2 = value2 )
    end
end
end