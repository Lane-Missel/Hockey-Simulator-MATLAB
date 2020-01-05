classdef Staff < handle

    properties

        name
        age
        nationality
        role

    end


    methods

        function self = Staff()

            self.name = input('Name: ');
            self.age = input('Age: ');
            self.nationality = input('Nationality: ');
            self.role = input('Role: ');
        end
    end
end
