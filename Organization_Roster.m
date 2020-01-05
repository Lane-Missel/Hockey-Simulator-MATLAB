classdef Organization_Roster < handle

    properties
        
        major
        minor
        unassigned = {}

        combined

    end


    methods

        function self = Organization_Roster(maj,minr)
            self.major = maj;
            self.minor = minr;
            self.combined = [self.major.roster; self.minor.roster; self.unassigned];
        end

        function self = Update()
            self.combined =  [self.major.roster; self.minor.roster; self.unassigned];
        end
    end
end
