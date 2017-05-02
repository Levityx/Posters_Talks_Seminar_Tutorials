classdef myClassEvent < handle
    
    properties (SetAccess='private')
        myMoney = 0;
    end
    
    properties (SetAccess='immutable')
        name@char
        minimumAcceptable@double
    end
    
    events
        valueChanged
        notThatMuchLeft
        ImInTheRedGodDammit
    end
    
    methods
        function obj = myClassEvent(nameGiven, minimumAcceptable)
            % Name should never be changed!!
            obj.name = nameGiven;
            obj.minimumAcceptable = minimumAcceptable;
            fprintf(1,'%s just created an account, currently empty.\n',nameGiven);
        end
        
        function receivedMoney( obj, moneyReceived )
            newValue = obj.myMoney + moneyReceived;
            fprintf(1,'%s just gained %.2f pounds. Has %.2f pounds.\n',obj.name, moneyReceived,newValue );
            obj.set('myMoney',newValue );
        end
        
        function spendMoney( obj, moneySpent )
            newValue = obj.myMoney- moneySpent ;
            fprintf(1,'%s just spent %.2f pounds. Has %.2f pounds.\n',obj.name, moneySpent,newValue );
            obj.set('myMoney', newValue);
        end

        function set( obj, prop, newValue )
            obj.(prop) = newValue;
            if newValue < obj.minimumAcceptable
                if newValue >= 0
                    notify( obj,'notThatMuchLeft' );
                else
                    notify( obj,'ImInTheRedGodDammit' );
                end
            end
        end
    end
end
    