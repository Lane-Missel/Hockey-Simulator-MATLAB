classdef Skater < handle

    properties

        personal
        attributes
        contract
        exhibitionStats
        majorStats
        minorStats
        
    end 


    methods

        function self = Skater()

            self.personal = Personal();
            self.attributes = Attributes();
            self.contract = Contract();
            self.exhibitionStats = Statistics();
            self.majorStats = Statistics();
            self.minorStats = Statistics();

        end
        
    end
end
