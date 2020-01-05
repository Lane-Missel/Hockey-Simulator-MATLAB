classdef Contract < handle

    properties

        years
        salary

    end


    methods

        function self = Contract()

            disp('Enter contract information:')
            self.years = input('Years: ');
            self.salary = input('Salary: ');

        end

    end
end
