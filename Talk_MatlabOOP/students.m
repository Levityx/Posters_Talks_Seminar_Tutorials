classdef students
    % Example of an enumeration class. Default methods are:
    % Default constructor (students in this case)
    % char ? converts enumeration members to character strings
    % eq ? enables use of == in expressions
    % ne ? enables use of ~= in expressions
    
    enumeration
        % All the values instances can take
        Alban, Toby, Dave, Oscar, Joel, Steaders
    end
    
    methods
        function out = isgoodstudent( obj )
            switch obj
                case students.Alban
                    out = '... srsly?';
                otherwise
                    out = 'He''s the best!';
            end
        end
    end
    
    
end