import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

test('example test passed', () => {
  render(<App />);
  const linkElement = screen.getByText(/learn react/i);
  expect(linkElement).toBeInTheDocument();
});
