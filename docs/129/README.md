# How to use arrays in bash

| Syntax          | Result                                  |
| --------------- | --------------------------------------- |
| `arr=()`        | Create an empty array                   |
| `arr=(1 2 3)`   | Initialize array                        |
| `${arr[2]}`     | Retrieve third element                  |
| `${arr[@]}`     | Retrieve all elements                   |
| `${!arr[@]}`    | Retrieve array indices                  |
| `${#arr[@]}`    | Calculate array size                    |
| `arr[0]=3`      | Overwrite 1st element                   |
| `arr+=(4)`      | Append value(s)                         |
| `str=$(ls)`     | Save ls output as a string              |
| `arr=( $(ls) )` | Save ls output as an array of files     |
| `${arr[@]:s:n}` | Retrieve n elements starting at index s |

Here are some examples:

- Print out all elements in an array.

  ```bash
  # print out contents in the array
  echo "${arr[@]}"
  ```

- Print out the first element in an array.  Need to verify this

  ```bash
  # print out contents in the array
  echo "${arr}"
  ```

Meta:

    tags: #bash #programming
