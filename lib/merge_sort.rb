module MergeSort
  def merge(array_a, array_b)
    merged = []
    until array_a.empty? && array_b.empty?
      return merged + array_a if array_b.empty?

      merged << array_a.shift if array_a[0] <= array_b[0]
      return merged + array_b if array_a.empty?

      merged << array_b.shift if array_b[0] <= array_a[0]
    end
    merged
  end

  def merge_sort(array)
    divider = (array.length - 1) / 2
    return array if array.length == 1

    a = merge_sort(array[0..divider])
    b = merge_sort(array[divider + 1..array.length - 1])
    merge(a, b)
  end
end
