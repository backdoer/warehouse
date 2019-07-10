from fractions import Fraction
import numpy as np

def solve_system_of_equations(matrix):
    equations = map(lambda x: x[0:-1], matrix)
    answers = map(lambda x: x[-1], matrix)
    A = np.array(list(equations))
    B = np.array(list(answers))
    result = np.linalg.solve(A, B)
    result_as_fractions = map(_get_fraction, result)

    return list(result_as_fractions)

def _get_fraction(decimal):
    fraction = Fraction(decimal).limit_denominator(10)
    return [fraction.numerator, fraction.denominator]
