classdef SyntaxColors % Adapted from Mathworks
   properties 
      % Add properties to an enumeration class when you must store data
      % related to the enumeration members. Set the property values
      % in the class constructor. For example, the SyntaxColors class
      % defines three properties whose values the constructor assigns
      % to the values of the input arguments when you reference a class
      % member, and a fourth one.
      RGB
      R
      G
      B
      
   end
   methods
       function c = SyntaxColors(r, g, b) % Only MATLAB can call this constructor.
           c.RGB = [r g b];
           c.R = r; c.G = g; c.B = b;
      end
   end
   enumeration
      Error   (1, 0, 0)
      Comment (0, 1, 0)
      Keyword (0, 0, 1)
      String  (1, 0, 1)
   end
   
   % Note: Because SyntaxColors is a value class (it does not derive from handle),
   % only the class constructor can set property values.

end