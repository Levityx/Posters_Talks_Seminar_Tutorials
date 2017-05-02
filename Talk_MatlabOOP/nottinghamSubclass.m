classdef nottinghamSubclass < nottinghamClass & matlab.System & myAbstractClass
    % nottinghamSubclass is a subclass of nottinghamClass and of 
    % matlab.System, so it inherits all properties and methods from 
    % nottinghamClass and matlab.System
    
    
    properties ( SetAccess = private )
        % Those properties are read-only for the user: 
        % only changeable via methods able to (ex: setNewProp)
        myNewProperty@char          = 'initialValue'
        % This property can't be changed
        myImmutableProp@char        = datestr( now )
        myNewPropertyRestr@char     = 'initialValue'
    end
    
    properties ( GetAccess = private )
        privateGetAccess = 'privateGetAccess contains: You can''t see me unless you call getPrivAcc.';
    end
    
    methods
        function set( obj, propName, value )
            % Overwrite set (defined in superclass)
            switch propName
                case 'myImmutableProp'
                    error('Don''t even try to change myImmutableProp');
                case 'myNewProperty'
                    obj.setNewProp(value);
            end 
        end
        
        function setNewProp( obj, value )
            % Only way to change property myNewProperty
            obj.myNewProperty = value;
        end
        
        function getPrivAcc( obj )
            disp( obj.privateGetAccess );
        end
    end
    
    % To demonstrate that private methods can be called by public ones
    methods ( Access='public' )
        function callPrivateMethod( obj, varargin )
            obj.myPrivateMethod('fromCallPrivateMethod');
        end
    end
    
    methods ( Access='private' )
        function myPrivateMethod( ~, str )
            fprintf(1, 'myPrivateMethod(obj, %s)\n', str );
        end
    end
    
    methods % Implement the abstract method from myAbstractClass.m
        function [a,b] = myAbstractMethod( obj, arg )
            a = arg;
            b = obj.myNewProperty;
        end
    end
    
    methods (Static)
        function myNewMethod 
            fprintf(1,'I''m the new method, only available to objects of class nottinghamSubclass.\n');
            fprintf(1,'As a static method, I''m callable from the class itself: nottinghamSubclass.myNewMethod();\n');
            fprintf(1,'I can be useful: Time is %s.\n', datestr( now ));
        end
    end
end
