def insert_at(string, position, insert):
    """Returns a copy of string with insert inserted at the position
    >>> string = "ABCDE"
    >>> result = []
    >>> for i in range(-2, len(string) + 2):
    ...     result.append(insert_at(string, i, "-"))
    >>> result[:5]
    ['ABC-DE', 'ABCD-E', '-ABCDE', 'A-BCDE', 'AB-CDE']
    >>> result[5:]
    ['ABC-DE', 'ABCD-E', 'ABCDE-', 'ABCDE-']
    """
    return string[:position] + insert + string[position:]
if __name__ == "__main__":
    import doctest
    doctest.testmod()