import React from 'react';

const createMarkup = (htmlContent) => {
  return { __html: htmlContent };
};

const JobOffer = (jobOffer) => {
  return (
    <div>
      <h2>
        <a href={jobOffer.url}>{ jobOffer.title }</a>
      </h2>
      <p dangerouslySetInnerHTML={createMarkup(jobOffer.content)}></p>
    </div>
  );
};

export default JobOffer;
