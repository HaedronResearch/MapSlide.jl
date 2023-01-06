There are two distinct sorts of windows that are taken over data: _rolling_ and _tiled_.  Rolling windows advance step-by-step over the data, each step advances the indices spanned by 1 (usually).  Tiled windows advance in larger steps (a multistep) over the data, each multistep advances the indices spanned by a preset amount, the length of the multistep.  

With tiled windows, the tiling (the span that describes the indices covered by each tile) and the multistep increment are usually the the same. An example is summarizing a week of daily data and then moving to the following week.  To use a multistep increment that is shorter than the tiling is permitted, as is the use of an increment that is longer than the the tiling -- although that is rarely needed.  An example might be summarizing a week of daily data and the skipping over the next week, moving to the second week following for some analytic purpose.



