classdef LCPHL < handle

    properties

        organizations

    end


    methods

        function self = LCPHL()
            self.organizations = {};
        end

        function self = AddOrganization(self)
            in = input('Enter new organization variable name: ')

            self.organizations = [self.oganizations; in];
        end
    end
