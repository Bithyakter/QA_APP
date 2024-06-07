
var QuestionController = {

    LstQuestions: () => {
        QuestionService.LstQuestions(function (response) {
            let questionContent = '';
            $.each(response, function (index, value) {
                console.log(response);

                let makeDate = new Date(value.makeDate);
                let timeDifference = new Date() - makeDate;
                let hoursDifference = Math.floor(timeDifference / (1000 * 60 * 60));

                questionContent += `                                            
                    
                        <h5 class="mb-2 fw-medium"><a href="question-details.html">${value.questionTitle}</a></h5>
                        <p class="mb-2 truncate lh-20 fs-15">${value.question}</p>
                        <div class="tags">
                            <a href="#" class="tag-link">javascript</a>
                            <a href="#" class="tag-link">bootstrap-4</a>
                            <a href="#" class="tag-link">jquery</a>
                            <a href="#" class="tag-link">select</a>
                        </div>
                                
                        <div class="media media-card user-media align-items-center px-0 border-bottom-0 pb-0">
                            <a href="#" class="media-img d-block">
                                <img src="~/Template/images/user1.png" alt="avatar">
                            </a>
                            <div class="media-body d-flex flex-wrap align-items-center justify-content-between">
                                <div>
                                    <h5 class="pb-1"><a href="Bithy#">${value.makeBy}</a></h5>
                               
                                </div>
                                <small class="meta d-block text-end">
                                    <span class="text-black d-block lh-18">asked</span>
                                    <span class="d-block lh-18 fs-12">${hoursDifference} hours ago</span>
                                </small>
                            </div>
                        </div>
                    `;
            })
            $('#dvQuestionList').html(questionContent);
        })
    }
}
