classdef myAbstractClass < handle
    % Abstract methods are implemented in subclasses, only syntax here.
    % myAbstractMethod defined in nottinghamSubclass.m
    methods (Abstract, Static)
        [a,b] = myAbstractMethod( obj, arg )
    end
end