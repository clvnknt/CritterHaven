const appearance = {
  theme: 'flat',
  variables: {
    fontFamily: 'Sohne, system-ui, sans-serif',
    fontWeightNormal: '500',
    borderRadius: '8px',
    colorBackground: '#FFFFFF',
    colorPrimary: '#EFC078',
    colorPrimaryText: '#1A1B25',
    colorText: 'white',
    colorTextSecondary: 'white',
    colorTextPlaceholder: '#727F96',
    colorIconTab: 'white',
    colorLogo: 'light'
  },
  rules: {
    '.Input, .Block': {
      backgroundColor: 'transparent',
      border: '1.5px solid var(--colorPrimary)'
    }
  }
};

// Pass the appearance object to the Elements instance
const elements = stripe.elements({clientSecret, appearance});