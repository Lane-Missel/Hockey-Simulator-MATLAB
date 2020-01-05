classdef Statistics < handle

    properties

        goals
        assists
        points
        plusMinus
        gamesPlayed

    end


    methods

        function self = Statistics()

            self.goals = 0;
            self.assists = 0;
            self.points = 0;
            self.plusMinus = 0;
            self.gamesPlayed = 0;
        end

        function [] = Goal(self)

            self.goals = self.goals + 1;
            self.points = self.points + 1;
        end

        function [] = Assist(self)

            self.assists = self.assists + 1;
            self.points = self.points + 1;
        end

        function [] = Plus(self)

            self.plusMinus = self.plusMinus + 1;
        end

        function [] = Minus(self)

            self.plusMinus = self.plusMinus - 1;
        end

        function [] = GamePlayed(self)

            self.gamesPlayed = self.gamesPlayed + 1;
        end

    end
end
