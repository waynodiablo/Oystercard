# The Escalation Process

### No developer is an island
At Makers Academy we're interested in students becoming autonomous problem-solvers. 'Autonomy', however, does *not* mean the ability to source solutions entirely from one's own brain. What it means is the ability to iteratively work through a problem with a series of tools, starting with the most immediately available, the 'cheapest', and culminating in the most 'expensive'. We have the following process within Makers Academy that we recommend students follow.

### The Process

1. After registering that a problem is blocking you and your pair partner, ensure that you have a test that specifically targets the problem. Rather than running your entire test suite and having to pick out the red, find the relevant command for executing only the failing test.

2. Apply your debugging skills to *diagnose*: try to visualize the chain of execution. What method within your test is resulting in the failure? What is the immediate cause of the failure? Examine the error message carefully.

3. Come up with a hypothesis about the cause of the problem. This is really important. Without some notion as to the cause, you'll just be making random changes to the codebase. Your hypothesis need not be deeply refined.

4. Test your hypothesis. Use 'puts' statements or a debugging tool such as byebug.

5. If your test goes green, congratulations! If not, repeat steps 3 to 4 a couple more times.

6. Google the error message. Scan the first few results for useful pointers.

7. Write up your problem in 3 - 4 sentences and post on your cohort's slack channel. Notify @channel and find out if any other students have encountered a similar problem or can help.

8. Escalate your problem to the Alumni Helper desk and ask for their advice on debugging the problem. Ideally they are able to give you helpful suggestions.

9. Congratulations! You've got a problem worthy of being an [issue](https://github.com/makersacademy/issues). The issues repo is intended as a stack-overflow style Q&A for use by students. Check out the readme for more details. **Remember** to post a link to a github repo. Ideally, you checkout your buggy code to a separate branch, push, and link to that.

10. If your issue is not addressed promptly, bring a coach's attention to it or flag them over.

### Tips on the above
Try not to think of alumni helpers and coaches as qualitatively different from other routes to solving a problem. Their expertise itself is a tool that you need to use carefully. If your codebase is a mess, you don't have relevant tests, or the problem you're having is otherwise obscured, they will struggle to be effective in helping you.
