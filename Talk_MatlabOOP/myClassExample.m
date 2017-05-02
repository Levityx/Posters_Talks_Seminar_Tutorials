% Script without myClass
a = 'initialValue';
b = a2b( a );
c = b2c( b );
if isa( c, 'char' )
    d = c2d_char( c );
elseif isa( c , 'double')
    d = c2d_num( c );
end

% Script with myClass
m = myClass( 'initialValue' );
m.a2b;
m.b2c;
m.c2d;


% Script with myClass and 'function obj =...'
m = myClass( 'initialValue' ).a2b.b2c.c2d;

% Script with myClass and one2another
m = one2another( myClass('initialValue'),'a','d' );