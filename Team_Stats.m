classdef Team_Stats < handle

    properties

        wins
        losses
        ties
        points
        gamesPlayed
        top
        percent
        shotsFor
        shotsAgainst
        goalsFor
        goalsAgainst

    end


    methods

        function self = Team_Stats(self)

            wins = 0;
            losses = 0;
            ties = 0;
            points = 0;
            gamesPlayed = 0;
            top = 0;
            percent = 0;
            shotsFor = 0;
            shotsAgainst = 0;
            goalsFor = 0;
            goalsAgainst = 0;
        end

        function self = Win(self)

            self.wins = self.wins + 1;
            self.gamesPlayed = self.gamesPlayed + 1;
            self.points = self.points + 2;
        end

        function self = Loss(self)

            self.losses = self.losses + 1;
            self.gamesPlayed = self.gamesPlayed + 1;
        end

        function self = Tie(self)

            self.ties = self.ties + 1;
            self.gamesPlayed = self.gamesPlayed + 1;
            self.points = self.points + 1;
        end

        function self = updateGoals(self,For,against)

            self.goalsFor = self.goalsFor + For;
            self.goalsAgainst = self.goalsAgainst + against;
        end

        function self = updateShots(self,For,against)

            self.shotsFor = self.shotsFor + For;
            self.shotsAgainst = self.shotsAgainst + against;
        end

        function self = AddTOP(self,amount)

            self.top = self.top + amount;
        end

        function self = UpdatePerc(self)

            self.percent = self.wins / self.gamesPlayed;
        end
    end
end
