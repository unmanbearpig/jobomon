import React from 'react';

const JobOffer = (jobOffer) => {
  return (
    <div>
      <h2>
        <a href={jobOffer.url}>{ jobOffer.title }</a>
      </h2>
      <p>{ jobOffer.content }</p>
    </div>
  );
};

export default JobOffer;
