classdef Office < handle

    % TODO:
    % methods for changing office positions

    properties
        owner
        president
        generalManager
        majorCoach
        minorCoach

    end


    methods

        function self = Office()

            disp('Creating new office:')

            self.owner = input('Enter owner variable name: ');
            self.president = input('Enter president variable name: ');
            self.generalManager = input('Enter general manager variable name: ');
            self.majorCoach = input('Enter major coach variable name: ');
            self.minorCoach = input('Enter minor coach variable name: ');
        end
    end
end
