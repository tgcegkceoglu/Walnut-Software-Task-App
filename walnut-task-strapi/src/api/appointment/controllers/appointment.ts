/**
 * appointment controller
 */

import { factories } from '@strapi/strapi'

export default factories.createCoreController('api::appointment.appointment', ({ strapi }) => ({
  async delete(ctx) {
    const { id } = ctx.params;
    console.log('Delete request received for appointment id:', id);

    // Silmeden önce kaydı alalım, varsa loglayalım
    const appointment = await strapi.db.query('api::appointment.appointment').findOne({ where: { id } });
    console.log('Appointment before delete:', appointment);

    // Orijinal delete işlemini çağır
    const response = await super.delete(ctx);

    console.log('Delete response:', response);

    return response;
  }
}));