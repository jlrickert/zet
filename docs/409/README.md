# Interesting bug in AWS ECS

I ran into an issue where create an cluster failed and was not able to re make
it as according to AWS it already exists. However, it wouldn't show up at all if
I searched the list either through CLI or GUI. To fix the issue I had to go to
got to AWS CloudFormation and delete the stack that was associated with he
cluster creation.

    tags: #aws
