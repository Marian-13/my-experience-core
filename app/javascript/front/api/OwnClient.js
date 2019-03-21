import axios from 'axios';

import { getToken } from '../lib/auth';

class OwnClient extends axios {}

const beforeRequestHandler = (config) => {
  const token = getAuthToken();

  if (token) config.headers = { ...config.headers, 'Authorization': `Bearer ${token}` };

  return config;
};

const successResponseHandler = (response) => {
  const { status, data } = response.data;

  return { status, data, response };
};

const failResponseHandler = (error) => {
  const { status, data, code, message } = error.response.data;

  if (status == 'fail') return Promise.reject({ status, data, response });
  if (status == 'error') return M.toast({ html: `Internal Server Error: ${message}` });
};

OwnClient.interceptors.request.use(beforeRequestHandler, error => Promise.reject(error));
OwnClient.interceptors.response.use(successResponseHandler, failResponseHandler);

export default OwnClient;
