import numpy as np
import matplotlib.pyplot as pp


class GameOfLife:
    def __init__(self, dimensions=None):
        if dimensions is None:
            self.system = np.random.randint(2, size=(10, 10))
            self.dimensions = {'x': 10, 'y': 10}
        else:
            self.system = np.random.randint(2, size=(dimensions['x'], dimensions['y']))
            self.dimensions = dimensions

    def run(self, n_steps):
        for step in range(n_steps):
            self.apply_rules()
            print('step: ', step)
            print('system: ', self.system)

    def export(self):
        return self.system

    def apply_rules(self):
        for x in range(self.dimensions['x']):
            for y in range(self.dimensions['y']):
                count = self.count_neighbors(x, y)

                if self.system[x][y] == 1 and count < 2:
                    self.system[x][y] = 0
                elif self.system[x][y] == 1 and (count == 2 or count == 3):
                    self.system[x][y] = 1
                elif self.system[x][y] == 1 and count > 3:
                    self.system[x][y] = 0
                elif self.system[x][y] == 0 and count == 3:
                    self.system[x][y] = 1

    def count_neighbors(self, x, y):
        count = 0
        for d_x in [-1, 0, 1]:
            for d_y in [-1, 0, 1]:
                if d_x == 0 and d_y == 0:
                    continue

                n_x = x + d_x
                n_y = y + d_y

                if n_x == 0 and n_y == 0:
                    count += self.system[self.dimensions['x'] - 1][self.dimensions['y'] - 1]
                elif n_x == 0 and n_y == self.dimensions['y']:
                    count += self.system[self.dimensions['x'] - 1][0]
                elif n_x == self.dimensions['x'] and n_y == self.dimensions['y']:
                    count += self.system[0][0]
                elif n_x == self.dimensions['x'] and n_y == 0:
                    count += self.system[0][self.dimensions['y'] - 1]
                elif n_x == 0:
                    count += self.system[self.dimensions['x'] - 1][n_y]
                elif n_x == self.dimensions['x']:
                    count += self.system[0][n_y]
                elif n_y == 0:
                    count += self.system[n_x][self.dimensions['y'] - 1]
                elif n_y == self.dimensions['y']:
                    count += self.system[n_x][0]
                else:
                    count += self.system[n_x][n_y]

        return count


class Graph:
    def plot(self, data=None):
        if data is None:
            self.data = np.random.randn(100, 100)
        else:
            self.data = data

        pp.imshow(self.data, interpolation='none', cmap='Greys')
        pp.axis('off')

    def save(self):
        pp.savefig('image.png', bbox_inches='tight')

    def show(self):
        pp.show()

if __name__ == "__main__":
    game_of_life = GameOfLife()
    game_of_life.run(100)
    graph = Graph()
    graph.plot(game_of_life.export())
    graph.save()
