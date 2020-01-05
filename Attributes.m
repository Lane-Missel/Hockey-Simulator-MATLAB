classdef Attributes < handle

    properties

        overall
        shooting
        passing
        defending
        goaltending

    end


    methods

        function self = Attributes()
            %{
                Allows user to enter player attributes.
            %}

            pos = input('Enter (1=skater,2=goaltender): ');

            if pos == 1
                % Player is a skater.
                disp('Enter player attributes:')
                self.shooting = input('Shooting: ');
                self.passing = input('Passing: ');
                self.defending = input('Defending: ');
                self.overall = ceil((self.shooting + self.passing + self.defending) / 3);

            elseif pos == 2
                % Player is a goaltender.
                disp('Enter goaltender attribute:')
                self.goaltending = input('Goaltending: ');
                self.overall = self.goaltending;

            else
                disp('Attributes not assigned for player.')
            end

        end

    end
end
