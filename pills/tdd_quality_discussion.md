Does TDD Guarantee Higher Code Quality?
======================================

TDD is not a guarantee of clean code, and if done incorrectly TDD can lead to appalling code. Even if done correctly TDD can lead to appalling code, but that is where the critical refactor step comes in. Code has to be evolved as it's being test driven in order to ensure it follows SOLID principles, removes code smells and makes effective use of design patterns

Either which way it would be a serious mistake to say any of the following things about solving a problem:

1. You MUST write a test first
2. You MUST sit back and ask questions first
3. You MUST draw a diagram first
4. You MUST write a user story first

The reality is that all of these things can play a part in solving a problem, but in reality there are no MUSTs. The things that comes closest to a MUST is that it really really really helps to understand why some of these tools actually help you solve problems.

Experimental studies indicate that using TDD leads to lower code defect rates at the expense of additional time to task completion (George & Williams, 2004; Bhat & Nagappan, 2006; Janzen & Saiedian, 2008b). However one should also ask how TDD helps programmers improve code quality. Some argue that TDD helps because it forces you to think carefully about the code you will write that helps you solve a problem. It is also argued that it helps you correctly test the desired behaviour of code you might write in the future, because if you write the test first then you know for certain that it should fail. If the test does not fail then you have solid evidence that you have not written the correct test because the code to make it pass has not been written yet. TDD helps (but does not guarantee) that you don't write a vacuous test that is a waste of everyone's time.

If we consider these two benefits of TDD we can see that there are many mechanisms that might aid us in thinking carefully about the code that we might be planning to write. Sitting back and asking questions of stakeholders, drawing diagrams & story-boards, creating user-stories, spending a long time in contemplation of a problem; all of these can help us think carefully about our code. Potentially more important is working out whether you actually need to write any code at all to solve a problem. The best problems are the ones that can be solved without writing any code, because then you will not experience any code maintenance burden, but that is another story.

So leaping in and writing a test immediately might or might not be the most effective way to really understand a problem. What about the second benefit, that of not writing vacuous tests? Clearly that's a benefit. However the same value can also be gained from writing the code that you want, then writing a test, checking that it passes, and then breaking the code, and ensuring that the test fails. This has exactly the same benefit as TDD. The danger however is that if you write the code first that you may be tempted to not write the test, or you may be tempted not to check that the test passes, and so perhaps TDD is a better approach for those who might succumb to the temptation; and let's face it we are all human.

So TDD has some advantages, but let's be clear about what they are, rather than being dogmatic about it. There are also certain problems with TDD in that some languages and frameworks do not have fully developed testing tools that make them difficult to test, let alone do TDD. Further, sometimes in the conceptualisation of the problem TDD introduces a second problem overloading one's cognitive capacity. Sometimes hard problems are difficult to consider by adding the additional problem of how to test first. This is dangerous of course; if you don't know how to test something in an automatic fashion then you are condemning yourself or the hapless fools that come after you, to have to test manually or just watch things break randomly. Perhaps the ideal solution is that if you have any problem for which you cannot conceive of a test, you should break the problem down or just switch to solving a different problem.

However many years of programming experience suggest that you can 'spike' a 'tracer-bullet' solution to a problem to help give you insight into how to create an automated test. The serious danger is that these temporary solutions might be pushed into production use without the addition of appropriate testing. One might argue that all spikes (untested code) must be deleted and re-written via TDD, which is certainly evidence of great engineering rigour, but the most critical thing is that any developer should have a clear understanding of the dangers. There are some problems that are very hard to approach with test driven development (TDD) - try TDDing Conway's Game of Life for example. Deleting your spikes and trying to re-create them TDD from memory is certainly a rigorous method, and might help novice developers avoid overly attaching themselves to their code, but there is also the concern of sailing too close to the wind. A working code example is golden; having one for reference is sometimes the difference between sanity and madness.

Both complete novices and junior developers should NOT be dogmatic in their approach to problem solving.

There is the question of whether insisting that novices TDD everything will be better for them in the long run? There is evidence that TDD improves novice code quality (Janzen & Saiedian, 2008a), but also that it is very difficult to convince novices to maintain test first behaviour, and that even under pressure to adopt TDD novices will not maintain it (Janzen & Saiedian, 2008b). This matches our own experience at Makers Academy in that there is no way to guarantee anyone uses TDD. Novices will do what they like and quickly find dangerous ways of doing things. As a software developer you really need to understand the dangers inherent in certain tools. As a novice you will experiment, fail and then learn your own lesson, which will last far longer than anything we can "teach" you.

There are also mixed results from studies that review the adoption of TDD across many institutions (Desai et al., 2008), and also evidence that test first can actually harm student project outcomes (Vu et al., 2009). It is a complex subject, but one relevant question to ask is whether an employer of developers would be far more impressed with a job candidate who could both articulate the dangers associated with different techniques of problem solving and employ them effectively, than with someone who felt that the first thing they MUST always do is write a test.

References
-------

* Bhat, T., & Nagappan, N. (2006). Evaluating the efficacy of test-driven development: industrial case studies. In Proceedings of the 2006 ACM/IEEE international symposium on Empirical software engineering (pp. 356-363). ACM.
* Desai, C., Janzen, D., & Savage, K. (2008). A survey of evidence for test-driven development in academia. ACM SIGCSE Bulletin, 40(2), 97-101.
* George, B., & Williams, L. (2004). A structured experiment of test-driven development. Information and software Technology, 46(5), 337-342.
* Janzen, D., & Saiedian, H. (2008a). Test-driven learning in early programming courses. In ACM SIGCSE Bulletin (Vol. 40, No. 1, pp. 532-536). ACM.
* Janzen, D. S., & Saiedian, H. (2008b). Does test-driven development really improve software design quality?. Software, IEEE, 25(2), 77-84.
* Vu, J. H., Frojd, N., Shenkel-Therolf, C., & Janzen, D. S. (2009). Evaluating test-driven development in an industry-sponsored capstone project. In Information Technology: New Generations, 2009. ITNG'09. Sixth International Conference on (pp. 229-234). IEEE.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/tdd_quality_discussion.md)
