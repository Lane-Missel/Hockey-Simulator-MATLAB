classdef Lineup < handle

    %{
        TODO:

        check that player is not on the same line
    %}

    properties
        
        one
        two
        goalie

    end


    methods

        function self = Lineup(one,two,goalie)

            disp('Creating new line:')
            self.one = one;
            self.two = two;
            self.goalie = goalie;
        end

    end
end
