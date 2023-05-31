const stripe = Stripe("pk_test_51LgIPQB33lx2a4f7hgbBQGUxdor0gpFJay34qMX9ieNxbFFyRwWHySzOYFPKG8sphVj5V3mL51iAX4wdGJNnQz3R00UpdKGWGd");


// Helper for displaying status messages.
const addMessage = (message) => {
  const messagesDiv = document.querySelector('#messages');
  messagesDiv.style.display = 'block';
  const messageWithLinks = addDashboardLinks(message);
  messagesDiv.innerHTML += `> ${messageWithLinks}<br>`;
  console.log(`Debug: ${message}`);
};

// Adds links for known Stripe objects to the Stripe dashboard.
const addDashboardLinks = (message) => {
  const piDashboardBase = 'https://dashboard.stripe.com/test/payments';
  return message.replace(
    /(pi_(\S*)\b)/g,
    `<a href="${piDashboardBase}/$1" target="_blank">$1</a>`
  );
};


const appearance = {
  theme: 'night',
  labels: 'floating',

};