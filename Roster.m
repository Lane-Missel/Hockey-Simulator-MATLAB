classdef Organization_Roster < handle

    properties
        
        major
        minor
        unassigned = {}

    end


    methods

        function self = Organization_Roster()
            self.major = input('Major team roster variable name: ');
            self.minor = input('Minor team roster variable name: ');
        end
    end
end
