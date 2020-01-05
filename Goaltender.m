classdef Goaltender < handle

    properties
        
        personal
        attributes
        contract
        exhibitionStats
        majorStats
        minorStats

    end
        

    methods

        function self = Goaltender()

            self.personal = Personal();
            self.attributes = Attributes();
            self.contract = Contract();
            self.exhibitionStats = Goal_Stats();
            self.majorStats = Goal_Stats();
            self.minorStats = Goal_Stats();

        end

    end
end
