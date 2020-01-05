classdef Goal_Stats < handle
    properties

        gamesPlayed
        shotsAgainst
        goalsAgainst
        gaa
        percent

    end


    methods

        function self = Goal_Stats()

            self.gamesPlayed = 0;
            self.shotsAgainst = 0;
            self.goalsAgainst = 0;
            self.percent = 0;

        end

        function self = GamePlayed(self)

            self.gamesPlayed = self.gamesPlayed + 1;
        end

        function self = shotAgainst(self)

            self.shotsAgainst = self.shotsAgainst + 1;
        end

        function self = goalAgainst(self)

            self.goalsAgainst = self.goalsAgainst + 1;
            self.shotsAgainst = self.shotsAgainst + 1;
        end

        function self = updateGaa(self)

            self.gaa = self.goalsAgainst / self.gamesPlayed;
        end

        function self = updatePercent(self)

            self.percent = 1 - (self.goalsAgainst / self.shotsAgainst);
        end
    end
end
