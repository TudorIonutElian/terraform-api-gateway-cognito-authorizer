export default handler = async (event) => {    
    return {
        statusCode: 200,
        body: JSON.stringify(`Response from Lambda function: ${JSON.stringify(event)}`),
    };
};