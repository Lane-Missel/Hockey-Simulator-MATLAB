classdef Boxscore < handle

    properties

        score = 0;
        first = 0;
        second = 0;
        shots = 0;
        top = 0;

    end


    methods

        function self = Boxscore()
        end

        function self = AddTop(self)

            self.top = self.top + 1;
        end

        function self = AddShot(self)

            self.shots = self.shots + 1;
        end

        function self = First(self)

            self.first = self.first + 1;
            self.score = self.score + 1;
            self.shots = self.shots + 1;
        end

        function self = Second(self)

            self.second = self.second + 1;
            self.score = self.score + 1;
            self.shots = self.shots + 1;
        end
    end
end
