import tensorflow as tf
from tensorflow.keras import layers, Model

# Define the generator model
def build_generator():
    model = tf.keras.Sequential()
    model.add(layers.Input(shape=(1, 256)))
    model.add(layers.Reshape((3, 4, 512)))
    model.add(layers.Conv2DTranspose(256, (6, 8), strides=4, padding='same'))
    model.add(layers.ReLU())
    model.add(layers.Conv2DTranspose(128, (12, 16), strides=4, padding='same'))
    model.add(layers.ReLU())
    model.add(layers.Conv2DTranspose(64, (24, 32), strides=4, padding='same'))
    model.add(layers.Activation('tanh'))
    model.add(layers.Reshape((48, 64, 1)))
    return model

# Define the discriminator model
def build_discriminator():
    model = tf.keras.Sequential()
    model.add(layers.Input(shape=(48, 64, 1)))
    model.add(layers.Flatten())
    model.add(layers.Dense(32, activation='relu'))
    model.add(layers.Dense(16, activation='relu'))
    model.add(layers.Dense(1, activation='sigmoid'))
    return model

@tf.function
def train_step(images):
    noise = tf.random.normal([BATCH_SIZE, noise_dim])

    with tf.GradientTape() as gen_tape, tf.GradientTape() as disc_tape:
        generated_images = generator(noise, training=True)

        real_output = discriminator(images, training=True)
        fake_output = discriminator(generated_images, training=True)

        gen_loss = generator_loss(fake_output)
        disc_loss = discriminator_loss(real_output, fake_output)

    gradients_of_generator = gen_tape.gradient(gen_loss, generator.trainable_variables)
    gradients_of_discriminator = disc_tape.gradient(disc_loss, discriminator.trainable_variables)

    generator_optimizer.apply_gradients(zip(gradients_of_generator, generator.trainable_variables))
    discriminator_optimizer.apply_gradients(zip(gradients_of_discriminator, discriminator.trainable_variables))

# Compile the discriminator
discriminator = build_discriminator()
discriminator.compile(loss='binary_crossentropy', optimizer=tf.keras.optimizers.Adam(learning_rate=0.0002))

# Compile the combined GAN model
discriminator.trainable = False
z = tf.keras.Input(shape=(1, 256))
gen_img = generator(z)
validity = discriminator(gen_img)
gan = Model(z, validity)
gan.compile(loss='binary_crossentropy', optimizer=tf.keras.optimizers.Adam(learning_rate=0.0002))