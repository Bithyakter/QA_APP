using System.Text.Json.Serialization;

namespace QA_API.Model
{
    public class QAQuestion
    {
        public int QuestionID { get; set; }
        public string Question { get; set; }
        public string MakeBy { get; set; }
        public DateTime MakeDate { get; set; }

        [JsonIgnore]
        public virtual ICollection<QAAnswer>? QAAnswers { get; set; }
    }
}