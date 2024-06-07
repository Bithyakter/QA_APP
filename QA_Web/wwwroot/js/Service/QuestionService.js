var QuestionService = {
    LstQuestions: (callback) => { 
        $.get("http://localhost:5244/api/questions-list", function (data, status) {
            callback(data);
        })
    }
}