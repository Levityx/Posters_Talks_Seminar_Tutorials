classdef classFromPackage < handle
    properties 
        propA
    end
    methods
        function methodA ( obj )
            obj.propA = 'A';
        end
    end
end