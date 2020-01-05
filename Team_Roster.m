classdef Team_Roster < handle

    properties

        roster

    end


    methods

        function self = Team_Roster()

            self.roster = {0; 0; 0; 0; 0; 0; 0; 0; 0; 0};
        end

        function self = AddPlayer(self,player)
            if length(self.roster) > 10
                disp('Cannot add player, roster is full.')

            else
                for i = 1:length(self.roster)
                    if self.roster{i} == 0
                        self.roster{i} = player;
                        break
                    end
                end
            end
        end

        function self = RemovePlayer(self,player)

            for i = 1:length(self.roster)

                if self.roster{i} == player
                    self.roster(i:end) = self.roster(i+1:end);
                    self.roster{end} = 0;
                    key = true
                end
            end

            if key == true
                disp('Player removed.')

            else
                disp('Player not found. Roster unchanged.')
            end
        end
    end
end
