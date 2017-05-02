classdef myClassNoHandle
    
    properties 
        a
        b
        c
        d
    end
    
    methods
        function obj = myClassNoHandle( initVal )
            obj.a = initVal;
        end
        
        function obj = a2b( obj )
            obj.b = [obj.a '_through_a2b'];
        end
        
        function obj = b2c( obj )
            obj.c = [obj.b '_through_b2c'];
        end
        
        function obj = c2d( obj )
            switch class( obj.c )
                case 'char',    c2d_char( obj );
                case 'double',  c2d_num ( obj );
            end
        end
        
        function obj = one2another( obj, in, out )
            ord = { 'a','b','c','d' };
            ind = find(strcmp(in, ord)):(find(strcmp(out, ord))-1);
            for kk=ind
                obj.([ord{kk} '2' ord{kk+1}]);
            end
        end
    end
       
    methods ( Hidden ) % My dirty little secrets
        % Hidden from user,  they don't appear in methods(myClass('1'))
        function c2d_char( obj )
            obj.d = [obj.c '_through_c2d_char'];
        end
        
        function c2d_num( obj )
            obj.d = [obj.c '_through_c2d_double'];
        end
    end
end