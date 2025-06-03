import { handler } from './index.mjs';

const mockEvent = {
  queryStringParameters: {}
  // Add any mock data you'd normally get from API Gateway
};

handler(mockEvent)
  .then(response => {
    console.log("Lambda Response:");
    console.log(response);
  })
  .catch(err => {
    console.error("Error during test:", err);
  });
