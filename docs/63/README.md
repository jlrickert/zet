# How does a generic search engine work for the web

A search engine gives a sorted list of page results based on a query. The order
is determined by a rank. This rank is determined by a set of parameters.

For example, a page's rank could be determined by TF\*IDF for each query term.

## Terminology

| Term                             | Description                                                              |
| -------------------------------- | ------------------------------------------------------------------------ |
| webserver                        |                                                                          |
| crawler                          | gathers information from the web                                         |
| indexer                          | gathers various metrics in a page                                        |
| Page rank algoritm               | gives a rank based on how many times a url is referenced by another page |
| url frontier                     | queue of links to crawl                                                  |
| robots.txt                       |                                                                          |
| Forward index                    | `document: word[]`                                                       |
| Inverted index                   | `word: document[]`                                                       |
| Term frequency (TF)              | unique word count / word count                                           |
| Inverse document frequency (IDF) | count of documents with unique word / document count                     |

Meta:

    #architecture #swe #csci
