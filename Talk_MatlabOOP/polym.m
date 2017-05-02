classdef polym < handle & matlab.mixin.Heterogeneous 
    % Superclass for heterogeneous array formation
    properties
        propPolym
    end
    methods (Sealed=true)
        function out = sealMeth( ~ )
            out = 0;
        end
    end
end