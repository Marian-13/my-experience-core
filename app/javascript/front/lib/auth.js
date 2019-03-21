export const getAuthToken = () => localStorage.getItem('token');
export const storeAuthToken = token => localStorage.setItem('token', token);

export const isUserLoggedIn = () => getAuthToken();
