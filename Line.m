classdef Line < handle

    properties

    one
    two
    three

    end


    methods

        function self = Line(one,two,three)

            self.one = one;
            self.two = two;
            self.three = three; 
            disp('Line created.')
        end

        function self = EditLine(self)
            disp('Current line:')
            fprintf('1: %s(%f)\n',self.one.personal.name,self.one.personal.overall)
            fprintf('1: %s(%f)\n',self.two.personal.name,self.two.personal.overall)
            fprintf('1: %s(%f)\n',self.three.personal.name,self.three.personal.overall)

            switch input('Which player would you like to replace? (1,2,3): ')
                case 1
                    player = self.one;
                case 2
                    player = self.two;
                case 3
                    player = self.three;
                otherwise
                    error('Invalid input.')
            end

            player = input('Enter player variable name: ');
        end

    end
end
