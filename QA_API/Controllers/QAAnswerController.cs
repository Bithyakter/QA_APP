using Microsoft.AspNetCore.Mvc;
using QA_API.Model;

namespace QA_API.Controllers
{
    [Route("api")]
    [ApiController]
    public class QAAnswerController : ControllerBase
    {
        private readonly List<QAAnswer> _answers;

        public QAAnswerController()
        {
            _answers = new List<QAAnswer>
            {
                new QAAnswer
                {
                    AnswerID = 1,
                    Answer = "This is the first answer.",
                    MakeBy = "Bithy",
                    MakeDate = DateTime.Now,
                    QuestionID = 1
                },
                new QAAnswer
                {
                    AnswerID = 2,
                    Answer = "This is the second answer.",
                    MakeBy = "Nitu",
                    MakeDate = DateTime.Now,
                    AnswerAcceptedBy = "Sharmin",
                    AnswerAcceptedDate = DateTime.Now,
                    QuestionID = 2
                }
            };
        }

        #region Submit Answer
        [Route("create-answer")]
        [HttpPost]
        public IActionResult SubmitAnswer(QAAnswer answer)
        {
            answer.AnswerID = _answers.Count + 1;
            answer.MakeDate = DateTime.Now;

            _answers.Add(answer);

            return Ok(answer);
        }
        #endregion

        #region Get Answer List
        [Route("answer-list")]
        [HttpGet]
        public IActionResult GetAnswerList()
        {
            return Ok(_answers);
        }
        #endregion

        #region Get Answer by Question
        [HttpGet("by-question/{questionId}")]
        public IActionResult GetAnswersByQuestionID(int questionId)
        {
            var answers = _answers.Where(a => a.QuestionID == questionId).ToList();

            if (!answers.Any())
                return NotFound($"No answers found for question ID {questionId}.");

            return Ok(answers);
        }
        #endregion

        #region check if an answer is accepted or not
        [HttpGet("is-answer-accepted/{answerId}")]
        public IActionResult IsAnswerAccepted(int answerId)
        {
            var answer = _answers.FirstOrDefault(a => a.AnswerID == answerId);

            if (answer == null)
                return NotFound($"Answer with ID {answerId} not found.");

            bool isAnswerAccepted = answer.AnswerAcceptedDate.HasValue;

            return Ok(isAnswerAccepted);
        }
        #endregion

        #region Get list of Accepted answer
        [HttpGet("accepted-answer-list")]
        public IActionResult GetAcceptedAnswers()
        {
            var acceptedAnswers = _answers.Where(a => a.AnswerAcceptedDate.HasValue).ToList();

            if (!acceptedAnswers.Any())
                return NotFound("No accepted answers found.");

            return Ok(acceptedAnswers);
        }
        #endregion

    }
}