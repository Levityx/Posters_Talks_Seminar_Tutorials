classdef myCreditor < handle
    properties (SetAccess='immutable')
        name
    end
    
    methods
        function obj = myCreditor(creditorName, debtor_obj, moneyGiven)
            % _debtor_ of class myClassEvent: the person the creditor gives
            % money to.
            obj.name = creditorName;
            debtor_obj.receivedMoney(moneyGiven);
            addlistener(debtor_obj,'ImInTheRedGodDammit',@(src,evt)obj.handleTheSituation(src,evt));
            % When ImInTheRedGodDammit event is triggered in debtor,
            % callback function myCreditor.handleTheSituation is executed.
        end
    end
    
     methods (Access=private)
         % http://fr.mathworks.com/help/matlab/matlab_oop/listener-callback-functions.html
      function handleTheSituation(  obj,src,~, varargin)%
          if src.myMoney > -200
              fprintf(1,'<strong>(From my %s''s head) Call %s and see what''s happening...</strong>\n',obj.name,src.name);
          else 
              fprintf(1,'<strong>(From my %s''s head) Call %s and see what the heck is happening...</strong>\n',obj.name,src.name);
          end
      end
   end
end