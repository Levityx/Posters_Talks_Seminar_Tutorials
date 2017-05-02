classdef nottinghamClass < handle
    % Subclass of handle made for today's seminar
    
    % Properties (optional: with their default values)
    properties 
        % Time of creation (first word disappeared in doc because property name!)
        time = datestr( now )
        
        % Local path to logo
        path2logo = fullfile('.','notts.jpg')
        
        % A figure with the logo
        logo = []
    end
    
    % One method block for each unique set of attribute specifications.
    % Unlike in Java or C++, you must pass an object of the class
    %   explicitly to the method.
    
    % Classes can define a special method to create objects, called a constructor. 
    % Constructor methods enable you to validate and assign property values.
    % Here is a constructor for the nottinghamClass class:
    methods 
        function obj = nottinghamClass( varargin )
            % Constructor method checking number of inputs
            if nargin == 2 || nargin > 3
                error('Dude, no more than one input.');
            elseif nargin == 3
                disp('Secret: 3 arguments is actually fine. It contains:');
                disp( varargin{3} );
            end
        end
    end
    
    methods ( Sealed=true )
        % Sealed because I do not plan to change those methods in subclasses
        
        function todaysLogo( obj )
            % Add time to Notts' logo
            A = imread( obj.path2logo );
            if isempty( obj.logo )
                obj.logo = figure;
            end
            image( A );
            axis equal
            axis off
            hold on
            text(1000,590,obj.time,'FontSize',15);
        end
        
        function saveasjpg( obj )
            % Save it in current directory
            if isempty( obj.logo )
                error('Run obj.todaysLogo before calling saveasjpg.');
            end 
            saveas( obj.logo, sprintf('notts_%s.jpg', obj.time) );
        end

    end
    
end
