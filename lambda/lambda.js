exports.handler = async (event) => {
    try {
        const name = (event.body)
        const response = {
            statusCode: 200,
            body: `ECHO: ${name}`,
        };
        return response;
    } catch (e) {
        return {
            statusCode: 500,
            body: `Por favor, lembre-se de seguir o formato: curl -d 'teste' http://localhost:4566/restapis/62h8ssdd61/apiLambdaStageNew/_user_request_/echoserver`
        }
    }
};