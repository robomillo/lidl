from dataclasses import dataclass


"""
3: Describe a solution where data does not fit into memory

Assuming the array is stored on disk as a file, it is possible to iterate
line by line through the data and store the previous_integers hash_map in a disk
based database like sqlite and run subsequent lookups against the database.

Essentially nothing is stored in memory if this configuratin is used.
"""


@dataclass
class Pair:
    first_value: int
    first_value_idx: int
    second_value: int
    second_value_idx: int


def find_target_sum(integer_list: list, target_sum: int):
    previous_integers = {}
    return_values: list = []
    for idx, value in enumerate(integer_list):
        temp = target_sum - value
        if temp in previous_integers:
            return_values.append(
                Pair(
                    first_value=temp,
                    first_value_idx=previous_integers[temp],
                    second_value=value,
                    second_value_idx=idx,
                )
            )
        previous_integers[value] = idx
    return return_values


if __name__ == "__main__":

    test_value = [3, 1, 14, 6, 10, 88, 14, 2, -14, 30]
    test_target = 16
    pairs = find_target_sum(test_value, test_target)
    for pair in pairs:
        print(pair, "\n")
